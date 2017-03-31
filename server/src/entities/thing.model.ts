'use strict';

import * as shortID from 'shortid';

export class Thing {
    private _thingID: string;

    public constructor(private _someProperty: string,
                       private _description: string,
                       private _userID: string) {
        this._thingID = shortID.generate();
    }

    public get thingID(): string {
        return this._thingID;
    }

    public get someProperty(): string {
        return this._someProperty;
    }
    public get description(): string {
        return this._description;
    }

    public get userID(): string {
        return this._userID;
    }

    public toJSON(): any {
        return {
            'thingID': this.thingID,
            'someProperty': this.someProperty,
            'description': this.description,
            'userID': this.userID,
        };
    }
}
