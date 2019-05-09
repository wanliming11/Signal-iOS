//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation
import GRDBCipher
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Record

public struct StickerPackRecord: Codable, FetchableRecord, PersistableRecord, TableRecord {
    public static let databaseTableName: String = StickerPackSerializer.table.tableName

    public let id: UInt64

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    public let recordType: SDSRecordType
    public let uniqueId: String

    // Base class properties
    public let author: String?
    public let cover: Data
    public let dateCreated: Date
    public let info: Data
    public let isInstalled: Bool
    public let items: Data
    public let title: String?

    public enum CodingKeys: String, CodingKey, ColumnExpression, CaseIterable {
        case id
        case recordType
        case uniqueId
        case author
        case cover
        case dateCreated
        case info
        case isInstalled
        case items
        case title
    }

    public static func columnName(_ column: StickerPackRecord.CodingKeys) -> String {
        return column.rawValue
    }

}

// MARK: - StringInterpolation

public extension String.StringInterpolation {
    mutating func appendInterpolation(columnForStickerPack column: StickerPackRecord.CodingKeys) {
        appendLiteral(StickerPackRecord.columnName(column))
    }
}

// MARK: - Deserialization

// TODO: Remove the other Deserialization extension.
// TODO: SDSDeserializer.
// TODO: Rework metadata to not include, for example, columns, column indices.
extension StickerPack {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func fromRecord(_ record: StickerPackRecord) throws -> StickerPack {

        switch record.recordType {
        case .stickerPack:

            let uniqueId: String = record.uniqueId
            let sortId: UInt64 = record.id
            let author: String? = SDSDeserialization.optionalString(record.author, name: "author")
            let coverSerialized: Data = record.cover
            let cover: StickerPackItem = try SDSDeserialization.unarchive(coverSerialized, name: "cover")
            let dateCreated: Date = record.dateCreated
            let infoSerialized: Data = record.info
            let info: StickerPackInfo = try SDSDeserialization.unarchive(infoSerialized, name: "info")
            let isInstalled: Bool = record.isInstalled
            let itemsSerialized: Data = record.items
            let items: [StickerPackItem] = try SDSDeserialization.unarchive(itemsSerialized, name: "items")
            let title: String? = SDSDeserialization.optionalString(record.title, name: "title")

            return StickerPack(uniqueId: uniqueId,
                               author: author,
                               cover: cover,
                               dateCreated: dateCreated,
                               info: info,
                               isInstalled: isInstalled,
                               items: items,
                               title: title)

        default:
            owsFailDebug("Unexpected record type: \(record.recordType)")
            throw SDSError.invalidValue
        }
    }
}

// MARK: - SDSSerializable

extension StickerPack: SDSSerializable {
    public var serializer: SDSSerializer {
        // Any subclass can be cast to it's superclass,
        // so the order of this switch statement matters.
        // We need to do a "depth first" search by type.
        switch self {
        default:
            return StickerPackSerializer(model: self)
        }
    }
}

// MARK: - Table Metadata

extension StickerPackSerializer {

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    static let recordTypeColumn = SDSColumnMetadata(columnName: "recordType", columnType: .int, columnIndex: 0)
    static let idColumn = SDSColumnMetadata(columnName: "id", columnType: .primaryKey, columnIndex: 1)
    static let uniqueIdColumn = SDSColumnMetadata(columnName: "uniqueId", columnType: .unicodeString, columnIndex: 2)
    // Base class properties
    static let authorColumn = SDSColumnMetadata(columnName: "author", columnType: .unicodeString, isOptional: true, columnIndex: 3)
    static let coverColumn = SDSColumnMetadata(columnName: "cover", columnType: .blob, columnIndex: 4)
    static let dateCreatedColumn = SDSColumnMetadata(columnName: "dateCreated", columnType: .int64, columnIndex: 5)
    static let infoColumn = SDSColumnMetadata(columnName: "info", columnType: .blob, columnIndex: 6)
    static let isInstalledColumn = SDSColumnMetadata(columnName: "isInstalled", columnType: .int, columnIndex: 7)
    static let itemsColumn = SDSColumnMetadata(columnName: "items", columnType: .blob, columnIndex: 8)
    static let titleColumn = SDSColumnMetadata(columnName: "title", columnType: .unicodeString, isOptional: true, columnIndex: 9)

    // TODO: We should decide on a naming convention for
    //       tables that store models.
    public static let table = SDSTableMetadata(tableName: "model_StickerPack", columns: [
        recordTypeColumn,
        idColumn,
        uniqueIdColumn,
        authorColumn,
        coverColumn,
        dateCreatedColumn,
        infoColumn,
        isInstalledColumn,
        itemsColumn,
        titleColumn
        ])

}

// MARK: - Deserialization

extension StickerPackSerializer {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func sdsDeserialize(statement: SelectStatement) throws -> StickerPack {

        if OWSIsDebugBuild() {
            guard statement.columnNames == table.selectColumnNames else {
                owsFailDebug("Unexpected columns: \(statement.columnNames) != \(table.selectColumnNames)")
                throw SDSError.invalidResult
            }
        }

        // SDSDeserializer is used to convert column values into Swift values.
        let deserializer = SDSDeserializer(sqliteStatement: statement.sqliteStatement)
        let recordTypeValue = try deserializer.int(at: 0)
        guard let recordType = SDSRecordType(rawValue: UInt(recordTypeValue)) else {
            owsFailDebug("Invalid recordType: \(recordTypeValue)")
            throw SDSError.invalidResult
        }
        switch recordType {
        case .stickerPack:

            let uniqueId = try deserializer.string(at: uniqueIdColumn.columnIndex)
            let author = try deserializer.optionalString(at: authorColumn.columnIndex)
            let coverSerialized: Data = try deserializer.blob(at: coverColumn.columnIndex)
            let cover: StickerPackItem = try SDSDeserializer.unarchive(coverSerialized)
            let dateCreated = try deserializer.date(at: dateCreatedColumn.columnIndex)
            let infoSerialized: Data = try deserializer.blob(at: infoColumn.columnIndex)
            let info: StickerPackInfo = try SDSDeserializer.unarchive(infoSerialized)
            let isInstalled = try deserializer.bool(at: isInstalledColumn.columnIndex)
            let itemsSerialized: Data = try deserializer.blob(at: itemsColumn.columnIndex)
            let items: [StickerPackItem] = try SDSDeserializer.unarchive(itemsSerialized)
            let title = try deserializer.optionalString(at: titleColumn.columnIndex)

            return StickerPack(uniqueId: uniqueId,
                               author: author,
                               cover: cover,
                               dateCreated: dateCreated,
                               info: info,
                               isInstalled: isInstalled,
                               items: items,
                               title: title)

        default:
            owsFail("Invalid record type \(recordType)")
        }
    }
}

// MARK: - Save/Remove/Update

@objc
extension StickerPack {
    public func anySave(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            save(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.save(entity: self, transaction: grdbTransaction)
        }
    }

    // This method is used by "updateWith..." methods.
    //
    // This model may be updated from many threads. We don't want to save
    // our local copy (this instance) since it may be out of date.  We also
    // want to avoid re-saving a model that has been deleted.  Therefore, we
    // use "updateWith..." methods to:
    //
    // a) Update a property of this instance.
    // b) If a copy of this model exists in the database, load an up-to-date copy,
    //    and update and save that copy.
    // b) If a copy of this model _DOES NOT_ exist in the database, do _NOT_ save
    //    this local instance.
    //
    // After "updateWith...":
    //
    // a) Any copy of this model in the database will have been updated.
    // b) The local property on this instance will always have been updated.
    // c) Other properties on this instance may be out of date.
    //
    // All mutable properties of this class have been made read-only to
    // prevent accidentally modifying them directly.
    //
    // This isn't a perfect arrangement, but in practice this will prevent
    // data loss and will resolve all known issues.
    public func anyUpdateWith(transaction: SDSAnyWriteTransaction, block: (StickerPack) -> Void) {
        guard let uniqueId = uniqueId else {
            owsFailDebug("Missing uniqueId.")
            return
        }

        guard let dbCopy = type(of: self).anyFetch(uniqueId: uniqueId,
                                                   transaction: transaction) else {
            return
        }

        block(self)
        block(dbCopy)

        dbCopy.anySave(transaction: transaction)
    }

    public func anyRemove(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            remove(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.delete(entity: self, transaction: grdbTransaction)
        }
    }
}

// MARK: - StickerPackCursor

@objc
public class StickerPackCursor: NSObject {
    private let cursor: SDSCursor<StickerPack>

    init(cursor: SDSCursor<StickerPack>) {
        self.cursor = cursor
    }

    // TODO: Revisit error handling in this class.
    public func next() throws -> StickerPack? {
        return try cursor.next()
    }

    public func all() throws -> [StickerPack] {
        return try cursor.all()
    }
}

// MARK: - Obj-C Fetch

// TODO: We may eventually want to define some combination of:
//
// * fetchCursor, fetchOne, fetchAll, etc. (ala GRDB)
// * Optional "where clause" parameters for filtering.
// * Async flavors with completions.
//
// TODO: I've defined flavors that take a read transaction.
//       Or we might take a "connection" if we end up having that class.
@objc
extension StickerPack {
    public class func grdbFetchCursor(transaction: GRDBReadTransaction) -> StickerPackCursor {
        return StickerPackCursor(cursor: SDSSerialization.fetchCursor(tableMetadata: StickerPackSerializer.table,
                                                                   transaction: transaction,
                                                                   deserialize: StickerPackSerializer.sdsDeserialize))
    }

    // Fetches a single model by "unique id".
    public class func anyFetch(uniqueId: String,
                               transaction: SDSAnyReadTransaction) -> StickerPack? {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return StickerPack.fetch(uniqueId: uniqueId, transaction: ydbTransaction)
        case .grdbRead(let grdbTransaction):
            let tableMetadata = StickerPackSerializer.table
            let columnNames: [String] = tableMetadata.selectColumnNames
            let columnsSQL: String = columnNames.map { $0.quotedDatabaseIdentifier }.joined(separator: ", ")
            let tableName: String = tableMetadata.tableName
            let uniqueIdColumnName: String = StickerPackSerializer.uniqueIdColumn.columnName
            let sql: String = "SELECT \(columnsSQL) FROM \(tableName.quotedDatabaseIdentifier) WHERE \(uniqueIdColumnName.quotedDatabaseIdentifier) == ?"

            let cursor = StickerPack.grdbFetchCursor(sql: sql,
                                                  arguments: [uniqueId],
                                                  transaction: grdbTransaction)
            do {
                return try cursor.next()
            } catch {
                owsFailDebug("error: \(error)")
                return nil
            }
        }
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    // Traversal aborts if the visitor returns false.
    public class func anyVisitAll(transaction: SDSAnyReadTransaction, visitor: @escaping (StickerPack) -> Bool) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            StickerPack.enumerateCollectionObjects(with: ydbTransaction) { (object, stop) in
                guard let value = object as? StickerPack else {
                    owsFailDebug("unexpected object: \(type(of: object))")
                    return
                }
                guard visitor(value) else {
                    stop.pointee = true
                    return
                }
            }
        case .grdbRead(let grdbTransaction):
            do {
                let cursor = StickerPack.grdbFetchCursor(transaction: grdbTransaction)
                while let value = try cursor.next() {
                    guard visitor(value) else {
                        return
                    }
                }
            } catch let error as NSError {
                owsFailDebug("Couldn't fetch models: \(error)")
            }
        }
    }

    // Does not order the results.
    public class func anyFetchAll(transaction: SDSAnyReadTransaction) -> [StickerPack] {
        var result = [StickerPack]()
        anyVisitAll(transaction: transaction) { (model) in
            result.append(model)
            return true
        }
        return result
    }
}

// MARK: - Swift Fetch

extension StickerPack {
    public class func grdbFetchCursor(sql: String,
                                      arguments: [DatabaseValueConvertible]?,
                                      transaction: GRDBReadTransaction) -> StickerPackCursor {
        var statementArguments: StatementArguments?
        if let arguments = arguments {
            guard let statementArgs = StatementArguments(arguments) else {
                owsFail("Could not convert arguments.")
            }
            statementArguments = statementArgs
        }
        return StickerPackCursor(cursor: SDSSerialization.fetchCursor(sql: sql,
                                                             arguments: statementArguments,
                                                             transaction: transaction,
                                                                   deserialize: StickerPackSerializer.sdsDeserialize))
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class StickerPackSerializer: SDSSerializer {

    private let model: StickerPack
    public required init(model: StickerPack) {
        self.model = model
    }

    public func serializableColumnTableMetadata() -> SDSTableMetadata {
        return StickerPackSerializer.table
    }

    public func insertColumnNames() -> [String] {
        // When we insert a new row, we include the following columns:
        //
        // * "record type"
        // * "unique id"
        // * ...all columns that we set when updating.
        return [
            StickerPackSerializer.recordTypeColumn.columnName,
            uniqueIdColumnName()
            ] + updateColumnNames()

    }

    public func insertColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            SDSRecordType.stickerPack.rawValue
            ] + [uniqueIdColumnValue()] + updateColumnValues()
        if OWSIsDebugBuild() {
            if result.count != insertColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(insertColumnNames().count)")
            }
        }
        return result
    }

    public func updateColumnNames() -> [String] {
        return [
            StickerPackSerializer.authorColumn,
            StickerPackSerializer.coverColumn,
            StickerPackSerializer.dateCreatedColumn,
            StickerPackSerializer.infoColumn,
            StickerPackSerializer.isInstalledColumn,
            StickerPackSerializer.itemsColumn,
            StickerPackSerializer.titleColumn
            ].map { $0.columnName }
    }

    public func updateColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            self.model.author ?? DatabaseValue.null,
            SDSDeserializer.archive(self.model.cover) ?? DatabaseValue.null,
            self.model.dateCreated,
            SDSDeserializer.archive(self.model.info) ?? DatabaseValue.null,
            self.model.isInstalled,
            SDSDeserializer.archive(self.model.items) ?? DatabaseValue.null,
            self.model.title ?? DatabaseValue.null

        ]
        if OWSIsDebugBuild() {
            if result.count != updateColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(updateColumnNames().count)")
            }
        }
        return result
    }

    public func uniqueIdColumnName() -> String {
        return StickerPackSerializer.uniqueIdColumn.columnName
    }

    // TODO: uniqueId is currently an optional on our models.
    //       We should probably make the return type here String?
    public func uniqueIdColumnValue() -> DatabaseValueConvertible {
        // FIXME remove force unwrap
        return model.uniqueId!
    }
}
